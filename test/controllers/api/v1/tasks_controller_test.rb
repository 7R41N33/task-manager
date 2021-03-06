require 'test_helper'

class Api::V1::TasksControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    author = create :manager
    task = create :task, author: author
    get api_v1_task_url(task.id, format: :json)
    assert_response :success
  end

  test 'should get index' do
    get api_v1_tasks_url(format: :json)
    assert_response :success
  end

  test 'should post create' do
    author = create :manager
    assignee = create :developer
    task_attributes = attributes_for(:task)
                      .merge(author_id: author.id, assignee_id: assignee.id)

    post api_v1_tasks_url(format: :json), params: { task: task_attributes }
    assert_response :success

    data = JSON.parse(response.body)
    created_task = Task.find(data['id'])

    assert created_task.present?
    assert_equal task_attributes.stringify_keys, created_task.slice(*task_attributes.keys)
  end

  test 'should put update' do
    author = create :manager
    assignee = create :developer
    task = create :task, author: author
    task_attributes = attributes_for(:task)
                      .merge(author_id: author.id, assignee_id: assignee.id)
                      .stringify_keys

    patch api_v1_task_url(task.id, format: :json), params: { task: task_attributes }
    assert_response :success

    task.reload
    assert_equal task.slice(*task_attributes.keys), task_attributes
  end

  test 'should delete destroy' do
    author = create :manager
    task = create :task, author: author
    delete api_v1_task_url(task.id, format: :json)
    assert_response :success

    assert !Task.where(id: task.id).exists?
  end
end
