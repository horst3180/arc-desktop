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

namespace Arc
{


public class HeaderWidget : Gtk.Box
{
    private Gtk.Image? image = null;
    private Gtk.Label? label = null;
    private Gtk.Button? exp_button = null;
    private Gtk.Button? close_button = null;

    public string? text {
        public set {
            this.label.set_label(value);
        }
        public get {
            return this.label.get_label();
        }
    }

    public string? icon_name {
        public set {
            this.image.set_from_icon_name(value, Gtk.IconSize.MENU);
        }
        public owned get {
            return this.image.icon_name;
        }
    }

    public bool can_close {
        public set {
            if (value) {
                this.close_button.show();
            } else {
                this.close_button.hide();
            }
        }
        public get {
            return this.close_button.get_visible();
        }
    }

    public bool expanded { public get; public set ; default = true; }

    /**
     * Emitted when this widget has been closed
     */
    public signal void closed();
            
    public HeaderWidget(string text, string icon_name, bool can_close)
    {
        Object(orientation: Gtk.Orientation.HORIZONTAL, spacing: 0);

        get_style_context().add_class("raven-expander");

        image = new Gtk.Image();
        image.margin_left = 8;
        image.margin_right = 8;
        pack_start(image, false, false, 0);

        label = new Gtk.Label(text);
        label.set_line_wrap(true);
        label.set_line_wrap_mode(Pango.WrapMode.WORD);
        label.halign = Gtk.Align.START;
        pack_start(label, true, true, 0);

        exp_button = new Gtk.Button.from_icon_name("pan-down-symbolic", Gtk.IconSize.MENU);
        exp_button.set_relief(Gtk.ReliefStyle.NONE);
        exp_button.clicked.connect(()=> {
            this.expanded = !this.expanded;
            if (!this.expanded) {
                (exp_button.get_image() as Gtk.Image).icon_name = "pan-end-symbolic";
            } else {
                (exp_button.get_image() as Gtk.Image).icon_name = "pan-down-symbolic";
            }
        });
        pack_end(exp_button, false, false, 0);

        show_all();

        close_button = new Gtk.Button.from_icon_name("window-close-symbolic", Gtk.IconSize.MENU);
        close_button.set_relief(Gtk.ReliefStyle.NONE);
        close_button.get_style_context().add_class("primary-control");
        close_button.no_show_all = true;
        close_button.get_child().show();
        pack_start(close_button, false, false, 0);

        close_button.clicked.connect(()=> {
            this.closed();
        });

        this.text = text;
        this.icon_name = icon_name;
        this.can_close = can_close;
    }
}

} /* End namespace */
