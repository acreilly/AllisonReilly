helpers do
    if production?
    after do
      ActiveRecord::Base.connection.close
    end
  end
end