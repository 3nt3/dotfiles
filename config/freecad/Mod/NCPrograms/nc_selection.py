# -*- coding: utf-8 -*-
# Clicking an NC program (tree group "NC Programs") also selects its operations,
# so they are highlighted in the tree and their toolpaths in the 3D view - like Fusion.

import os

import FreeCAD
import FreeCADGui

_LIB = None


def _lib():
    """program_ops() etc. from NC_Post_Process.FCMacro, loaded on first use."""
    global _LIB
    if _LIB is None:
        path = os.path.join(FreeCAD.getUserMacroDir(True), "NC_Post_Process.FCMacro")
        ns = {"__name__": "nc_selection_lib"}
        exec(compile(open(path, encoding="utf-8").read(), path, "exec"), ns)
        _LIB = ns
    return _LIB


def _is_program(o):
    return o is not None and hasattr(o, "ProgramNumber") and hasattr(o, "Operations") and hasattr(o, "Job")


class _Observer:
    def __init__(self):
        self.busy = False

    def addSelection(self, doc_name, obj_name, sub, pnt):
        if self.busy:
            return
        doc = FreeCAD.getDocument(doc_name)
        prog = doc.getObject(obj_name) if doc else None
        if not _is_program(prog):
            return
        from PySide import QtCore
        QtCore.QTimer.singleShot(0, lambda: self._select_ops(doc, prog))  # not from inside the callback

    def _select_ops(self, doc, prog):
        try:
            names = _lib()["program_ops"](doc, prog)
        except Exception as e:
            FreeCAD.Console.PrintWarning("NC programs: %s\n" % e)
            return
        self.busy = True
        try:
            for n in names:
                op = doc.getObject(n)
                if op is not None and not FreeCADGui.Selection.isSelected(op):
                    FreeCADGui.Selection.addSelection(op)
        finally:
            self.busy = False


def install():
    old = getattr(FreeCADGui, "_nc_program_observer", None)
    if old is not None:
        try:
            FreeCADGui.Selection.removeObserver(old)
        except Exception:
            pass
    obs = _Observer()
    FreeCADGui.Selection.addObserver(obs)
    FreeCADGui._nc_program_observer = obs
    return obs
