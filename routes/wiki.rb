get '/wiki/drop/:mid.?:format?' do
  map_id = params[:mid].to_i

  enemy_hash = {}
  DropShipRecord.where(mapId: map_id).distinct(:cellId).sort.each do |cell_id|
    enemy_hash[KCConstants.cells[map_id][cell_id]] ||= []
    enemy_hash[KCConstants.cells[map_id][cell_id]].push cell_id
  end

  result = []
  enemy_hash.each do |enemy_name, cell_id_list|
    ship_list = DropShipRecord.where(:mapId => map_id, :cellId.in => cell_id_list, :shipId.gt => -1).distinct(:shipId)
    result.push({ name: enemy_name, ships: ship_list})
  end

  response = ''
  result.each do |item|
    item[:name] =~ /-([A-Z])\)/
    pos = $1
    arr = item[:ships].group_by do |x|
      info = KCConstants.ship_infos[KCConstants.ships[x]]
      case info[:ship_type]
      when 'dd'
        '驱逐'
      when 'cl'
        '轻巡'
      when 'ca'
        '重巡'
      when 'bb'
        '战舰'
      when 'cv'
        '空母'
      when 'cvl'
        '空母'
      when 'ss'
        '潜艇'
      when 'ssv'
        '潜艇'
      else
        '其他'
      end
    end

    response += "&lt;!---------- #{pos}点 掉落 -----------&gt;<br />"
    response += "{{海域掉落列表|位置=#{pos}<br />"
    ['驱逐', '轻巡', '重巡', '战舰', '空母', '潜艇', '其他'].each do |type|
      response += "|#{type}="
      if arr.include?(type)
        response += (arr[type].map do |i|
          ship = KCConstants.ships[i]
          info = KCConstants.ship_infos[ship]
          if info[:rare]
            "&lt;span style='color: #f00 !important;'&gt;'''[[#{info[:chinese_name]}|&lt;span style='color: red'&gt;#{info[:chinese_name]}&lt;/span&gt;]]'''&lt;/span&gt;"
          else
            "[[#{info[:chinese_name]}]]"
          end
        end).join('，')
      end
      response += "<br />"
    end

    response += "}}<br />"
  end

  response
end