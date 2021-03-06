class Api::V1::TasksController < Api::V1::ApplicationController
  def show
    task = Task.find(params[:id])
    respond_with(task)
  end

  def index
    q_params = params[:q] || { s: 'id asc' }

    tasks = Task.all
                .includes(:author, :assignee)
                .ransack(q_params)
                .result
                .page(params[:page])
                .per(params[:per_page])

    json = {
      items: tasks.map { |t| TaskSerializer.new(t).as_json },
      meta: build_meta(tasks)
    }

    respond_with json
  end

  def create
    task = Task.new(task_params)

    if task.save
      respond_with(task, location: nil)
    else
      render(json: { errors: task.errors }, status: :unprocessable_entity)
    end
  end

  def update
    task = Task.find(params[:id])

    if task.update(task_params)
      render(json: task)
    else
      render(json: { errors: task.errors }, status: :unprocessable_entity)
    end
  end

  def destroy
    task = Task.find(params[:id])

    if task.destroy
      head(:ok)
    else
      render(json: { errors: task.errors }, status: :unprocessable_entity)
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :author_id, :assignee_id, :state_event)
  end
end
