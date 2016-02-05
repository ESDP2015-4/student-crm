class StudyUnitsController < ApplicationController
  before_action :set_study_unit, only: [:update, :edit]
  def index
    @study_units = StudyUnit.all
  end

  def new
    @study_unit = StudyUnit.new
  end

  def create
    @study_unit = StudyUnit.new(study_unit_params)

    if @study_unit.save
      redirect_to study_units_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @study_unit.update(study_unit_params)
      redirect_to study_units_url
    else
      render 'edit'
    end
  end

  private
  def set_study_unit
    @study_unit = StudyUnit.find(params[:id])
  end

  def study_unit_params
    params.require(:study_unit).permit(:title)
  end
end
