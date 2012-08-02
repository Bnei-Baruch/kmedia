class DowncaseSuids < ActiveRecord::Migration
  def up

    # note: my be slow but I couldn't find a way to use update_all with dynamic values.

    Dictionary.all.each do |dict|
      dict.update_attributes(suid: dict.suid.downcase)
    end
    Label.all.each do |lbl|
      lbl.update_attributes(suid: lbl.suid.downcase)
    end
  end

  def down
    # may be throw an IrreversibleMigration exception ?
  end
end
