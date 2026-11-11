# -*- coding: utf-8 -*-
# On start-up: make sure the "NC Program" / "Post Process NC programs" macro commands exist
# and sit on an "NC Programs" toolbar in the CAM workbench (fresh machine from the dotfiles).

import os

import FreeCAD
import FreeCADGui

COMMANDS = [
    ("NC_Program.FCMacro", "NC Program",
     "Create or edit an NC program (like Fusion): select operations or an NC program first"),
    ("NC_Post_Process.FCMacro", "Post Process NC programs",
     "Post the selected NC programs (or all of them)"),
]


def ensure_toolbar():
    macro_dir = FreeCAD.getUserMacroDir(True)
    names = []
    for script, text, tip in COMMANDS:
        if not os.path.exists(os.path.join(macro_dir, script)):
            continue
        name = FreeCADGui.Command.findCustomCommand(script)  # already registered?
        if not name:
            name = FreeCADGui.Command.createCustomCommand(script, text, tip, tip, tip, "", "")
        names.append(name)
    if not names:
        return
    bars = FreeCAD.ParamGet("User parameter:BaseApp/Workbench/CAMWorkbench/Toolbar")
    bar = None
    for g in bars.GetGroups():
        if bars.GetGroup(g).GetString("Name") == "NC Programs":
            bar = bars.GetGroup(g)
    if bar is None:
        n = 1
        while "Custom_%d" % n in bars.GetGroups():
            n += 1
        bar = bars.GetGroup("Custom_%d" % n)
        bar.SetString("Name", "NC Programs")
        bar.SetBool("Active", True)
    for name in names:
        bar.SetString(name, "FreeCAD")
