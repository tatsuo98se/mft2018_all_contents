$hw_ctrl_module = {
    chdir: './3d_led_cube2',
    spawn: "python main_hw_controller_module.py",
}

$hw_ctrl_module_dummy = {
    chdir: './3d_led_cube2',
    spawn: "python main_hw_controller_module_dummy.py",
}

$paint_service = {
    chdir: './3d_led_cube2',
    spawn: "python main_paint_service.py -d 192.168.0.20:5301",
}

$paint_service_offline = {
    chdir: './3d_led_cube2',
    spawn: "python main_paint_service.py",
}

$rs_module = {
    chdir: './3d_led_cube2',
    spawn: "python main_realsense_module.py",
}

$rs_service = {
    chdir: './3d_led_cube2',
    spawn: "python main_realsense_service.py -d 192.168.0.20:5401",
}

$block_service = {
    chdir: './3d_led_cube2',
    spawn: "python main_block_service.py -d 192.168.0.20:5101",
}

$block_test = {
    chdir: './3d_led_cube2',
    spawn: "python main_block_test.py",
}

$demo = {
    chdir: './3d_led_cube1/content/c++/taro-mori_demo/msvc/Release',
    spawn: "demo.exe -u 192.168.0.20 -p 5201",
}

$selector = {
    chdir: './select_contents',
    spawn: "bundle exec rackup -P rack.pid",
}

$sleeper = {
    chdir: './',
    spawn: "ruby dummy_process.rb",
}