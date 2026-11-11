# NC programs helper (Fusion-style NC programs for FreeCAD CAM):
#  - clicking an NC program selects (highlights) its operations
#  - makes sure the "NC Programs" toolbar with its two buttons exists in the CAM workbench
import FreeCAD

for _mod, _fn in (("nc_selection", "install"), ("nc_setup", "ensure_toolbar")):
    try:
        getattr(__import__(_mod), _fn)()
    except Exception as e:  # never break FreeCAD's start-up
        FreeCAD.Console.PrintWarning("NCPrograms (%s): %s\n" % (_mod, e))
