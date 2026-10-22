{
  flake.overlays.pyopenjtalk-plus = _: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (python-final: python-prev: {
        pyopenjtalk-plus = python-prev.pyopenjtalk-plus.overridePythonAttrs (old: {
          disabledTests = (old.disabledTests or [ ]) ++ [
            "test_run_njd_from_mecab_invalid_input_should_not_break_next_call"
          ];
        });
      })
    ];
  };
}
