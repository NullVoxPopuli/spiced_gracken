Vedeu.keymap('_global_') do
  # see http://www.rubydoc.info/gems/vedeu/Vedeu/DSL/Keymap

  key(:ctrl_c) { Vedeu.trigger(:_exit_) }
  key(:esc) do
    # TODO: show hotkey help interface
    Vedeu.trigger(:_mode_switch_)
  end
  key(:shift_tab) { Vedeu.trigger(:_focus_previous_) }
  key(:tab)       { Vedeu.trigger(:_focus_next_) }
end
