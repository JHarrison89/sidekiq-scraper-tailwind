# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :set_user
  before_action :redirect_unless_admin
  before_action :set_job, only: %i[show edit update destroy]

  layout "account"

  include JobUserCounter

  # GET /jobs or /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1 or /jobs/1.json
  def show
    set_status
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs or /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to job_url(@job), notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to job_url(@job), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = Current.user
  end

  def redirect_unless_admin
    redirect_to account_path unless @user.email == "jeremaia.harrison@gmail.com"
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def set_status
    status = JobUser.find_by(job_id: @job.id, user_id: Current.user.id)&.status
    @status = status.nil? ? :none : status.to_sym
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:company_name, :title, :url)
  end
end
