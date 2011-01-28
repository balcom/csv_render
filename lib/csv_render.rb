require "action_controller"
require "fastercsv"
ActionController::Renderers.add :csv do |object, options|
  object = [object] if object.class != Array
  column_names = object.first.class.column_names
  csv = FasterCSV.generate(:col_sep => ";", :row_sep => "\r\n") do |c|
    c << column_names
    object.each do |o|
      c << column_names.collect do |cn|
        o.attributes[cn]
      end
    end
  end
  send_data(csv, :filename => "#{object.first.class.to_s_tableize}.csv",
    :type => "text/csv", :disposition => "attachment")
end