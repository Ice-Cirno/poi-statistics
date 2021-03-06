require 'json'

get '/event-food2018/?' do
  haml :'event-food2018/index', :locals => {
    :location => 'event',
    :title_append => " # 活动统计 - 2018年食物迷你活动",
    :ship_data => [565, 517, 518, 524, 525, 531, 540, 551, 552].map {|i| {
      :id => i,
      :data => JSON.parse(get_kv_data("event_food2018_drop_ship_#{i}")),
    }},
    :item_data_180515 => [85, 86, 87, 88].map {|i| {
      :id => i,
      :data => JSON.parse(get_kv_data("event_food2018_180515_drop_item_#{i}")),
    }},
    :item_data_180518 => [85, 86, 87, 88].map {|i| {
      :id => i,
      :data => JSON.parse(get_kv_data("event_food2018_180518_drop_item_#{i}")),
    }},
    :item_data_180524 => [85, 86, 87, 88].map {|i| {
      :id => i,
      :data => JSON.parse(get_kv_data("event_food2018_180524_drop_item_#{i}")),
    }},
    :item_data_180601 => [85, 86, 87, 88].map {|i| {
      :id => i,
      :data => JSON.parse(get_kv_data("event_food2018_180601_drop_item_#{i}")),
    }},
    :item_data_180608 => [85, 86, 87, 88].map {|i| {
      :id => i,
      :data => JSON.parse(get_kv_data("event_food2018_180608_drop_item_#{i}")),
    }},
  }
end
