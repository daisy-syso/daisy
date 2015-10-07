editor = Editor.new
editor.email = 'admin@admin.com'
editor.username = 'dasiy_manager'
editor.telephone = '15201991025'
editor.password = 'Daisy1234'

if editor.save
  editor.add_role :admin
else
  puts editor.errors.full_messages
end