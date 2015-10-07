editor = Editor.new
editor.email = '651019063@qq.com'
editor.username = 'menghuanwd'
editor.telephone = '15201991025'
editor.password = 'Daisy1234'

if editor.save
  editor.add_role :admin
else
  puts editor.errors.full_messages
end