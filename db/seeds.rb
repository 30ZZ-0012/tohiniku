# require './models/item.rb'
if Category.count == 0
  Category.create([
    {name: '歩き (自転車)'},
    {name: 'バイク'},
    {name: '車'},
    {name: '飛行機'},
    {name: '電車'},
    {name: 'その他'}

  ])
end