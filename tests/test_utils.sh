
. ../liquidprompt --no-activate

function test_line_count {
  typeset test_string="a normal string"
  _lp_line_count "$test_string"
  assertEquals "normal 1 line string" $(printf %s "$test_string" | wc -l) $count

  test_string="\
    a
    longer
    string"
  _lp_line_count "$test_string"
  assertEquals "3 line string" $(printf %s "$test_string" | wc -l) $count

  test_string="\
    a

    longer

    string


    with many consecutive breaks"
  _lp_line_count "$test_string"
  assertEquals "consecutive blank lines string" $(printf %s "$test_string" | wc -l) $count

  test_string=""
  _lp_line_count "$test_string"
  assertEquals "null string" $(printf %s "$test_string" | wc -l) $count
}

function test_home_tilde_collapsed {
  typeset HOME="/home/user"
  typeset PWD="/a/test/path"
  _lp_get_home_tilde_collapsed
  assertEquals "unchanged path" "$PWD" "$lp_work_dir"

  PWD="/home/user/a/test/path"
  _lp_get_home_tilde_collapsed
  assertEquals "shorted home path" "~/a/test/path" "$lp_work_dir"
}

if [ -n "${ZSH_VERSION-}" ]; then
  SHUNIT_PARENT="$0"
  setopt shwordsplit
fi

. ./shunit2
