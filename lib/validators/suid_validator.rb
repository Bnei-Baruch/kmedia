class SuidValidator < ActiveModel::Validator
  def validate(record)
    #suid = record.suid
    #
    #if suid.nil? || suid.length < 3 || suid.length > 20
    #
    #
    #record.send(:validates, :suid, presence: true, uniqueness: true, length: 3..20, format: /[\w\.\-]+/)
  end
end