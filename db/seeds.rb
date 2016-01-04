editor = Editor.find_or_create_by(
  email: 'admin@admin.com',
  username: 'dasiy_manager',
  telephone: '15201991025',
  password: 'Daisy1234'
)

if editor.save
  editor.add_role :admin
else
  puts editor.errors.full_messages
end