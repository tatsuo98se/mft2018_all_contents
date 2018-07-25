require './process_def'
require './process_runner'

processes = [
    $hw_ctrl_module,
    $paint_service_rmt,
    $rs_service_rmt,
    $block_service_rmt,
    $demo,
    $selector,
    $audio_module,
]

run_processes processes