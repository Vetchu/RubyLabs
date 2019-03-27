module FileHandler

  def FileHandler.commit_to_file
    File.open('./db', 'wb') {|f| f.write($db.to_json)}
  end

  def FileHandler.load_string_from_file
    a = ""
    if File.exist?('./db') && !File.zero?('./db')
      a = File.read('./db')
    end
    a
  end

  def FileHandler.load_from_file
    $db = JSON.parse(load_string_from_file)
  end

  def showdb
    puts $db
  end
end