require "action_controller"
require "fastercsv"

class CsvRender
  def self.generate_csv(object, csv_options, file_options)
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
    ActionController::Renderers.send_data(csv, :filename => "#{object.first.class.to_s.tableize}.#{file_options[:extension]}",
      :type => file_options[:type], :disposition => "attachment")
  end
end

ActionController::Renderers.add :csv do |object, options|
  CsvRender.generate_csv(object, {:col_sep => "\t", :row_sep => "\r\n"}, {:extension => "csv", :type => "text/csv"})
end

ActionController::Renderers.add :xls do |object, options|
  CsvRender.generate_csv(object, {:col_sep => "\t", :row_sep => "\r\n"}, {:extension => "xls", :type => "application/vnd.ms-excel"})
end