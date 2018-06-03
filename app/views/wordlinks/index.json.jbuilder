# frozen_string_literal: true

if @wordlinks.any?
  too_big = @wordlinks.count > 50
  satiated = false
  json.array!(@wordlinks) do |wl|
    if too_big and wl.english != params[:term]
      next if satiated
      json.english 'Too many results - use a more exact search'
      json.reg false
      satiated = true
    else
      json.english    wl.english
      json.hint       wl.hint
      json.wlid       wl.wlid
      json.wc         I18n.t(wl.wc, scope: 'words.classes')
      json.reg        true
    end
  end
else
  json.array! [{ english: 'No results found', reg: false }]
end
