require 'rest-client'
class MedicineController < ApplicationController
  def index
  end
  def new
    @pre = Prescription.find(params[:id])
  end

  def show
    @medicine = Medicine.find(params[:id])
    url2= "http://apis.data.go.kr/1471057/MdcinPrductPrmisnInfoService/getMdcinPrductItem?serviceKey=E2jsmZxBSixMSoE%2BLNUvZzfn5m0trRAq8atIoypCwgDMuGvLzXMglJVJ71Q%2BF%2FPmvD%2BoQToeHoMDFyEkY7iY2Q%3D%3D"
    res = RestClient.get(url2, params: {item_name: Medicine.find(params[:id]).title})
    @item = Hash.from_xml(res.body)["response"]["body"]["items"]["item"]
  end

  def delete
    medi = Medicine.find(params[:id])
    medi.destroy
    redirect_back(fallback_location: root_path)
  end

  def create
    hash = params[:medicine].to_unsafe_h()
    keys = hash.keys()
    keys.each do |key|
      url1="http://apis.data.go.kr/1471057/MdcinPrductPrmisnInfoService/getMdcinPrductList?serviceKey=E2jsmZxBSixMSoE%2BLNUvZzfn5m0trRAq8atIoypCwgDMuGvLzXMglJVJ71Q%2BF%2FPmvD%2BoQToeHoMDFyEkY7iY2Q%3D%3D"
      url2="http://apis.data.go.kr/1471057/MdcinPrductPrmisnInfoService/getMdcinPrductIrdntItem?serviceKey=E2jsmZxBSixMSoE%2BLNUvZzfn5m0trRAq8atIoypCwgDMuGvLzXMglJVJ71Q%2BF%2FPmvD%2BoQToeHoMDFyEkY7iY2Q%3D%3D"
      res = RestClient.get(url1, params: {item_name: key})
      res2 = RestClient.get(url2, params: {Prduct: key})
      item = Hash.from_xml(res.body)["response"]["body"]["items"]["item"]
      medi = Medicine.create(title: key,code: item["ITEM_SEQ"],ps_date: Time.now,quantity: Prescription.find(params[:id]).cnt,take_time: hash[key]["take_time"],user_id: 1,prescription_id: params[:id])
      item2 = Hash.from_xml(res2.body)["response"]["body"]["items"]
      item2["item"].each do |item|
        url3 = "http://apis.data.go.kr/1470000/DURIrdntInfoService/getCpctyAtentInfoList?ServiceKey=E2jsmZxBSixMSoE%2BLNUvZzfn5m0trRAq8atIoypCwgDMuGvLzXMglJVJ71Q%2BF%2FPmvD%2BoQToeHoMDFyEkY7iY2Q%3D%3D"
        res3 = RestClient.get(url3,params: {ingrName: item["MTRAL_NM"]})
        item3 = Hash.from_xml(res3.body)["response"]["body"]["items"]
        if item3.nil?
          Ingr.create(medicine_id: medi.id,name: item["MTRAL_NM"], qnt: item["QNT"].to_i)
        else
          Ingr.create(medicine_id: medi.id,name: item["MTRAL_NM"], qnt: item["QNT"].to_i, max: item3["item"]["MAX_QTY"])
        end
      end
    end
    redirect_to root_path
  end

  def api
    url1="http://apis.data.go.kr/1471057/MdcinPrductPrmisnInfoService/getMdcinPrductList?serviceKey=E2jsmZxBSixMSoE%2BLNUvZzfn5m0trRAq8atIoypCwgDMuGvLzXMglJVJ71Q%2BF%2FPmvD%2BoQToeHoMDFyEkY7iY2Q%3D%3D"
    res = RestClient.get(url1,params: {item_name: params[:name]})
    @cnt=Hash.from_xml(res.body)["response"]["body"]["totalCount"]
    @items=Hash.from_xml(res.body)["response"]["body"]["items"]
    respond_to do |format|
      format.js
    end
    # puts(@items["item"])
    # render xml: @items
  end
end
