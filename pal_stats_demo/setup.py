from setuptools import find_packages, setup

package_name = 'pal_stats_demo'

setup(
    name=package_name,
    version='0.0.1',
    packages=find_packages(exclude=['test']),
    data_files=[
        # ROS 2 package registration
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        # Install launch files
        (
            'share/' + package_name + '/launch',
            ['launch/test_forward_position_controller.launch.py']
        ),
        # Install config files
        (
            'share/' + package_name + '/config',
            ['config/rrbot_forward_position_publisher.yaml']
        ),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='Maximilien Naveau',
    maintainer_email='maximilien.naveau@pal-robotics.com',
    description='Demo package for pal_statistics introspection',
    license='BSD 2-clause',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            (
                'publisher_forward_position_controller = '
                'pal_stats_demo.publisher_forward_position_controller:main'
            ),
        ],
    },
)
