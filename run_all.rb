require './process_def'
require './process_runner'

processes = [
    $hw_ctrl_module,
    $paint_service,
    $rs_module,
    $rs_service,
    $block_service,
    $demo,
    $selector,
]

run_processes processes