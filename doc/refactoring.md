# [fit] Refactoring

---

# Agenda

* Refactoring Recap
* Practice - Greatbook
* Moving to Procore
* Practice - Procore
* Next Steps

---

# Refactoring Recap

---

# [fit] If it ain't broke,
# [fit] **don't fix it**

---

> Make the change easy (warning: this may be hard), then make the easy change
-- @KentBeck

---

# **Refactoring Recap**

New requirements help guide you to a purposeful refactoring

---

# **Refactoring Recap**

* Is it open?
* Do you know how to make it open?
* Pick the smell most related to the problem and fix it
* Repeat

----

# **Refactoring Recap**

* Set the tightest feedback loop you can
* Take the smallest, safest step you can
* Other techniques?

---

# [fit] Practice:
# [fit] **Greatbook**

---

# [fit] **A new requirement**
# [fit] **appears:**
# [fit] _add support for +/- grades_

---

# [fit] Moving to
# [fit] **Procore**

---

# **Procore**

* Process challenges - setting a testing loop
* [Death Stars](https://docs.google.com/spreadsheets/d/1mEe3bOXIGFfcVcSfwUW2yG028Yjqdv2mPsD8skAQv8w/edit#gid=127047015)
* Tools like [reek](https://github.com/troessner/reek) and [flay](http://ruby.sadi.st/Flay.html)

---

# [fit] Practice:
# [fit] **Procore**

---

# Practice - **Procore**

* [Ex.](https://github.com/procore/procore/blob/f709fc19622b359ae629ca81f9c2bd92775eef12/app/drops/payment_application_line_item_group_summary_drop.rb#L12) - add a `line_item_count` method.
* [Ex.](https://github.com/procore/procore/blob/f709fc19622b359ae629ca81f9c2bd92775eef12/app/models/contract.rb#L536) - support a `time` based accounting method to track time spent on a not well-defined task.
* [Ex.]( https://github.com/procore/procore/blob/1c817314b6399d44960343a876b2aed6dcbd7e3c/app/services/reporting/column_types.rb) - add support for a new type, like `Array`. See [this PR](https://github.com/procore/procore/pull/33905).

---

# **Next Steps**

* Over the next month, work on folding refactoring into feature work
* Prepare examples or problems for next time
* Post questions / comments along the way in #refactoring

^ Also, consider working on refactoring katas or small code smells
