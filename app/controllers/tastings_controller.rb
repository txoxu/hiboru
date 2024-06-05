class TastingsController < ApplicationController
  before_action :set_whiskey
  before_action :set_tasting, only: [:edit, :update, :show, :destroy] 

  def new
    @tasting = @whiskey.tastings.build
  end

  def create
    @tasting = @whiskey.tastings.build(tasting_params)
    tag_list = params[:tasting][:tag_names].split(',')

    if @tasting.save
      @tasting.save_tags(tag_list)
      redirect_to choose_next_step_whiskey_path(@whiskey), notice: 'テイスティングを登録しました'
    else
      render 'new'
    end
  end

  def show
    tags = @tasting.tags
  end

  def edit
    @tag_names = @tasting.tags.pluck(:tag_name)
  end

  def update
    tag_list = params[:tasting][:tag_names].split(',')

    if @tasting.update(tasting_params)
      @tasting.save_tags(tag_list)
      redirect_to whiskey_tasting_path(@whiskey), notice: 'テイスティングを編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @tasting.destroy
    redirect_to whiskey_path(@whiskey), notice: 'テイスティングを削除しました', status: :see_other
  end

  private

  def set_whiskey
    @whiskey = Whiskey.find(params[:whiskey_id])
  end

  def set_tasting
    @tasting = @whiskey.tastings.find(params[:id])
  end

  def tasting_params
    params.require(:tasting).permit(:tasting_type, :flavor, :aroma, :tasting_text, :whiskey_id, tag_ids: [])
  end

end
