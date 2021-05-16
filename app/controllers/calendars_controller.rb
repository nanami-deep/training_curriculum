class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end


  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end
  # 概要

#本来であれば、予定は下記のように保存され、日付のボックスに表示される。
#しかし今回は、DBにも保存されず、表示もされていない。

#エラー画面が出ないので、パラメーターやバリデーションの問題だと思うが、問題を見つけ修正してほしい。

# 正しい動作

#![training](https://user-images.githubusercontent.com/46220963/79291687-3e4f3400-7f0a-11ea-98f8-c52b55a74422.gif)

  private

  def plan_params
    params.require(:plan).permit(:plan, :date)
  end

  def getWeek
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :plans => today_plans}
      @week_days.push(days)
    end

  end
end
