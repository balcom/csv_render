require "action_controller"
require "fastercsv"

class CsvRender
  def self.generate_csv(object, csv_options)
    object = [object] if object.class != Array
    column_names = object.first.class.column_names
    csv = FasterCSV.generate(csv_options) do |c|
      c << column_names
      object.each do |o|
        c << column_names.collect do |cn|
          o.attributes[cn].to_s.gsub(/(\r\n|\t)/, ',')
        end
      end
    end
    return csv
  end
end

ActionController::Renderers.add :csv do |object, options|
  csv = CsvRender.generate_csv(object, {:col_sep => "\t", :row_sep => "\r\n"})
  send_data(csv, :filename => "#{object.first.class.to_s.tableize}.csv",
    :type => "text/csv", :disposition => "attachment")
end

ActionController::Renderers.add :xls do |object, options|
  csv = CsvRender.generate_csv(object, {:col_sep => "\t", :row_sep => "\r\n"})
  send_data(csv, :filename => "#{object.first.class.to_s.tableize}.xls",
    :type => "application/vnd.ms-excel", :disposition => "attachment")
end