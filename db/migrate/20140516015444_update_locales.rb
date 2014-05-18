class UpdateLocales < ActiveRecord::Migration
  def up
    {
        tk: :tr,
        sw: :sv,
        si: :sl
    }.each_pair{|key, value|
      l = Language.where(locale: key).first
      next unless l
      l.update_attribute :locale, value
    }
  end

  def down
  end
end
