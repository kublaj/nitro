Base = require 'base'
mousetrap = require 'mousetrap'
keys = require '../utils/keys'
Views = require '../controllers/views'
Mouse = require '../utils/mouse'

class Keys

  bind: (key, fn) ->
    # keys = [ 'meta+' + key,  'ctrl+' + key ]
    mousetrap.bind key, (e) ->
      e.preventDefault()
      fn(e)


  constructor: ->

    @bind 'j', @nextList
    @bind 'k', @prevList
    @bind 'f', @search
    @bind ',', @settings
    @bind 'n', @newTask
    @bind 'l', @newList
    @bind 'p', @priority

    @bind ['del', 'backspace'], @deleteTasks


  ###
   * ACTIONS
  ###

  escape: ->

    # Escape
    # - hide modals
    # - collapse tasks

    console.log 'escaping'

    if Views.modal.displayed
      Views.modal.current.hide()

    else
      Views.tasks.collapse()

  newTask: ->

    # New Task
    # - focus the task input box

    Views.tasks.focus()

  newList: ->

    # New List
    # - focus the list input box

    Views.lists.focus()

  search:  ->

    # Search
    # - open the all tasks list
    # - and focus the task input box

    Views.list.all.open()
    Views.tasks.focus()

  settings: ->

    # Settings
    # - show the settings modal

    Views.settings.show()

  prevList: ->

    # Go to the previous list
    # - load the previous list

    Views.lists.prev()

  nextList: ->

    # Go to the next list
    # - load the next list

    Views.lists.next()

  priority: ->

    # Priority
    # - Cycle between priority

    # Views.tasks.
    selected = Mouse.tasks.selected()
    for el in selected
      el.task.increasePriority()

  deleteTasks: ->
    Mouse.tasks.trigger 'menu:delete', Mouse.tasks.selected()


module.exports = Keys
