

--- 2025 - 04 - 04 ---

    Trying to figure out the setup of the guiController and the modules related to it (ie. buttonController) 
    has been rather difficult. buttonController being a standalone module at the time of writing has made it a bit tricky to
    integrate with the guiController.

    The current plan is to dismantle guiController's textbox functionality into its own module like buttonController is. 
    From there I will reprogram buttonController to accept a textbox object as a parameter. Hopefully that works.

    Added class names.
    Added functions guiController. 

    Changed prefixes of textbox, (was textBox).
    Changed buttonController to add onto the textbox and change class name. 
        - Essentially creating proper inheritance.
    
    



---                ---