Polymer
  ready: ->

  onSelect: ->
    @date.selected = true
    @fire 'selected', @date
    return
