require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?
require 'rom/sql'


# class Students < ROM::Relation[:http]
#   schema do
#     attribute :id, Types::Int
#     attribute :first_name, Types::String
#     attribute :last_name, Types::String
#     attribute :external, Types::Bool
#     primary_key :id
#   end
# end
# class Subjects < ROM::Relation[:http]
#   schema do
#     attribute :id, Types::Int
#     attribute :name, Types::String
#     primary_key :id
#   end
# end
# class Teachers < ROM::Relation[:http]
#   schema do
#     attribute :id, Types::Int
#     attribute :first_name, Types::String
#     attribute :last_name, Types::String
#     attribute :subject, Types::Int
#     primary_key :id
#   end
# end
# class Grades < ROM::Relation[:http]
#   schema do
#     attribute :id, Types::Int
#     attribute :score, Types::Float
#     attribute :type, Types::Int
#     attribute :student_id, Types::Int
#     attribute :subject_id, Types::Int
#
#     primary_key :id
#   end
# end

class DeaneryApp < Sinatra::Base
  register Sinatra::Namespace

  namespace '/student' do

    get /\/*/ do
      erb :my_grades, :layout => :my_layout
    end
  end
  namespace '/teacher' do

    get /\/*/ do
      erb :teacher, :layout => :my_layout
    end

    get '/insert/student' do
      erb :student_insert, :layout => :my_layout
    end

    get '/insert/grade' do
      erb :grade_insert, :layout => :my_layout
    end

    post '/insert/student' do
      @name = params["name"]
      @surname = params["surname"]
      @external = params["external"]

      erb :student_insert, :layout => :my_layout
    end

    post '/insert/grade' do
      @name = params["name"]
      @surname = params["surname"]
      @external = params["external"]
      @grade = params["grade"]

      erb :grade_insert, :layout => :my_layout
    end
  end

  get /\/*/ do
    erb :index, :layout => :my_layout
  end

  post /\/*/ do
    @name = params["name"]
    @surname = params["surname"]
    erb :index, :layout => :my_layout
  end
end

if __FILE__ == $0
  DeaneryApp.run!
end