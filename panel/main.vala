/*
 * This file is part of arc-desktop
 * 
 * Copyright 2015 Ikey Doherty <ikey@solus-project.com>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

static bool replace = false;

const GLib.OptionEntry[] options = {
    { "replace", 0, 0, OptionArg.NONE, ref replace, "Replace currently running panel" },
    { null }
};

public static int main(string[] args)
{
    Gtk.init(ref args);
    OptionContext ctx;

    ctx = new OptionContext("- Arc Panel");
    ctx.set_help_enabled(true);
    ctx.add_main_entries(options, null);
    ctx.add_group(Gtk.get_option_group(false));

    try {
        ctx.parse(ref args);
    } catch (Error e) {
        stderr.printf("Error: %s\n", e.message);
        return 0;
    }

    var manager = new Arc.PanelManager();
    manager.serve(replace);

    Gtk.main();
    return 0;
}
