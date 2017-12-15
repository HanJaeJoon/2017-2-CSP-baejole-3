class HomeController < ApplicationController
  def index
    @prescriptions = Prescription.all
    @medicines = Medicine.all
    @caution = Hash.new
    @bool = false
    @result = ""
    @medicines.each do |m|
      m.ingrs.each do |ingr|
        unless ingr.max == nil
          if @caution[ingr.name] == nil
            @caution[ingr.name] = {"exist"=> ingr.qnt, "max" => ingr.max}
          else
            @caution[ingr.name]["exist"] += ingr.qnt
          end
        end
        @caution.keys.each do |key|
          if @caution[key]["exist"] >= @caution[key]["max"]
            @bool = true
            @result = key
            @yak = m.title
          end
        end
      end
    end
  end
end
