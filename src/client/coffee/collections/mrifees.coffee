window.FF.Collections.MriFees = window.FF.Collections.Fees.extend

  comparator: (fee1, fee2) ->
    
    f1 = fee1.toJSON()
    f2 = fee2.toJSON()

    # TC component should have priority for mri fees
    if f1.modifier1 != f2.modifier1
      return (if f1.modifier1.toUpperCase() == 'TC' then -1 else 1)

    # continue sorting normally
    window.FF.Collections.Fees::comparator.call this, fee1, fee2