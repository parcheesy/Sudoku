#Add gsub function to FileUtils
#WARNING: Don't use on extremely large files as this function reads entire file into memory
module FileUtils

  def FileUtils.gsub(file_name, replaced_string, replacing_string)
    f = File.read(file_name)
    f = f.gsub(replaced_string, replacing_string)
    File.write(file_name, f)
  end


end
