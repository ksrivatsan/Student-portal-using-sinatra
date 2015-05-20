require 'dm-core'
require 'dm-migrations'

# DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/student.db")

class Student

  include DataMapper::Resource
  
  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :age, Integer
  property :phone_number, String
  property :address, Text

end

DataMapper.finalize

get '/students' do
  @students = Student.all
  slim :students
end

get '/students/new' do
  @student = Student.new
  slim :new_student
end

get '/students/:id' do
	@student = Student.get(params[:id])
	slim :show_student
end

get '/students/:id/edit' do
  @student = Student.get(params[:id])
  slim :edit_student
end

post '/students' do  
  student = Student.create(params[:student])
  redirect to("/students/#{student.id}")
end

put '/students/:id' do
  student = Student.get(params[:id])
  student.update(params[:student])
  redirect to("/students/#{student.id}")
end

delete '/students/:id' do
  Student.get(params[:id]).destroy
  redirect to('/students')
end