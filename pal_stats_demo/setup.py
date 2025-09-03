from setuptools import find_packages, setup
from setuptools.command.install import install
import os
import shutil

package_name = 'pal_stats_demo'


class CustomInstallCommand(install):
    def run(self):
        install.run(self)
        # Copy all files from bin to lib/<project_name>
        bin_dir = self.install_scripts
        lib_dir = os.path.join(self.install_lib, 'lib', package_name)
        os.makedirs(lib_dir, exist_ok=True)
        if os.path.isdir(bin_dir):
            for fname in os.listdir(bin_dir):
                print("Copying", fname, "to", lib_dir)
                src = os.path.join(bin_dir, fname)
                dst = os.path.join(lib_dir, fname)
                if os.path.isfile(src):
                    shutil.copy2(src, dst)


setup(
    name=package_name,
    version='0.0.1',
    packages=find_packages(exclude=['test']),
    package_dir={},
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
    license='BSD',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'publisher_forward_position_controller = pal_stats_demo.publisher_forward_position_controller:main'
        ],
    },
    cmdclass={
        'install': CustomInstallCommand,
    },
)
