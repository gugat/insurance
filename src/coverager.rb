Dir[File.join(__dir__, 'coverages', '*.rb')].each { |file| require file }

class Coverager
  def self.for(type)
    klass_name = type.include?('Coverage') ? type : (type + 'Coverage')
    self.class.const_get(klass_name.delete(' ')).new
  rescue NameError
    DefaultCoverage.new
  end
end
