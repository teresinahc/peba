# encoding: utf-8
class String
  def titleize_name
    titleized = self.mb_chars.titleize.to_s
    titleized.gsub(/\s(Da|Das|De|Do|Dos)\s/) {|s| s.downcase }
  end
end
