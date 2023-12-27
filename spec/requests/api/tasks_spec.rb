require 'rails_helper'

RSpec.describe "Api::Tasks", type: :request do
  describe "GET /api/tasks" do
    it "returns a list of tasks" do
      create_list(:task_list, 20)
       
      get '/api/tasks'
      expect(response).to have_http_status(200)
      expect(json_response.size).to eq(10)
    end
  end

  describe "POST /api/tasks" do
    it "returns errors if task creation fails" do
      post '/api/tasks', params: { task: attributes_for(:task) }
      expect(response).to have_http_status(201)
      expect(Task.count).to eq(1)
    end

    it "returns errors if task creation fails" do
      post '/api/tasks', params: { task: { title: nil } }
      expect(response).to have_http_status(422)
      expect(json_response).to have_key("title")
    end
  end

  describe "GET /api/tasks/:id" do
    it "returns a tasks by id" do
      task = create(:task)

      get "/api/tasks/#{task.id}"
      expect(response).to have_http_status(200)
      expect(json_response["title"]).to eq(task.title)
    end

    it "returns 404 if task is not found" do
      get '/api/tasks/123123'
      expect(response).to have_http_status(404)
    end
  end

  describe "PUT /api/tasks/:id" do
    it "updates an existing task" do
      task = create(:task)
      new_title = "New title of existing task"
      
      put "/api/tasks/#{task.id}", params: {task: {title: new_title}}
      expect(response).to have_http_status(200)
      expect(task.reload.title).to eq(new_title)
    end

    it "returns errors if task update fails" do 
      task = create(:task)

      put "/api/tasks/#{task.id}", params: {task: {title: nil }}
      expect(response).to have_http_status(422)
      expect(json_response).to have_key("title")
    end
  end

  describe "DELETE /api/tasks/:id" do
    it "updates an existing task" do
      task = create(:task)
      
      delete "/api/tasks/#{task.id}"
      expect(response).to have_http_status(204)
      expect(Task.count).to eq(0)
    end

    it "returns 404 if task is not found" do 
      task = create(:task)

      get "/api/tasks/99999"
      expect(response).to have_http_status(404)
    end
  end
end
