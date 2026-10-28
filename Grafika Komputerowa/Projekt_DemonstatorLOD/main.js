import * as THREE from 'https://cdn.jsdelivr.net/npm/three@0.118/build/three.module.js';

import {FBXLoader} from 'https://cdn.jsdelivr.net/npm/three@0.118.1/examples/jsm/loaders/FBXLoader.js';

import {OrbitControls} from 'https://cdn.jsdelivr.net/npm/three@0.118/examples/jsm/controls/OrbitControls.js';

class LODDemo {
  constructor() {
    this._Initialize();
  }

  _Initialize() {
    this._threejs = new THREE.WebGLRenderer({
      antialias: true,
    });

    this._threejs.shadowMap.enabled = true;
    this._threejs.shadowMap.type = THREE.PCFSoftShadowMap;
    this._threejs.setPixelRatio(2*window.devicePixelRatio);
    this._threejs.setSize(window.innerWidth, window.innerHeight);

    document.body.appendChild(this._threejs.domElement);

    window.addEventListener('resize', () => {
      this._OnWindowResize();
    }, false);

    const fov = 60;
    const aspect = 1920 / 1080;
    const near = 1.0;
    const far = 1000.0;
    this._camera = new THREE.PerspectiveCamera(fov, aspect, near, far);
    this._camera.position.set(35, 10, 0);

    this._scene = new THREE.Scene();

    let light = new THREE.DirectionalLight(0xFFFFFF, 1.5);
    light.position.set(-100, 100, -100);
    light.target.position.set(0, 0, 0);
    light.castShadow = true;
    light.shadow.bias = -0.0001;
    light.shadow.mapSize.width = 2048;
    light.shadow.mapSize.height = 2048;
    light.shadow.camera.near = 0.1;
    light.shadow.camera.far = 500.0;
    light.shadow.camera.near = 0.5;
    light.shadow.camera.far = 500.0;
    light.shadow.camera.left = 10;
    light.shadow.camera.right = -10;
    light.shadow.camera.top = 10;
    light.shadow.camera.bottom = -10;
    this._scene.add(light);

    light = new THREE.AmbientLight(0xFFFFFF, 0.8);
    this._scene.add(light);

    const controls = new OrbitControls(
      this._camera, this._threejs.domElement);
    controls.target.set(0, 5, 0);
    controls.update();

    const loader = new THREE.CubeTextureLoader();
    const texture = loader.load([
        './resources/textures/posx.jpg',
        './resources/textures/negx.jpg',
        './resources/textures/posy.jpg',
        './resources/textures/negy.jpg',
        './resources/textures/posz.jpg',
        './resources/textures/negz.jpg',
    ]);
    this._scene.background = texture;

    const plane = new THREE.Mesh(
        new THREE.PlaneGeometry(500, 500, 100, 100),
        new THREE.MeshStandardMaterial({
            color: 0x202020,
          }));

    plane.castShadow = false;
    plane.receiveShadow = true;
    plane.rotation.x = -Math.PI / 2;
    plane.material.side = THREE.DoubleSide;
    plane.scale.multiplyScalar(0.05);

    this._scene.add(plane);
    this._mixers = [];
    this._previousRAF = null;

    const loaderFbx = new FBXLoader();

    const lod = new THREE.LOD();
    
    loaderFbx.setPath('./resources/models/')

    loaderFbx.load('slon4.fbx', (ele4) => {
      ele4.traverse(c => {
        c.castShadow = true;
      });
      ele4.scale.multiplyScalar(0.02); 
      lod.addLevel(ele4, 0);
    });

    loaderFbx.load('slon3.fbx', (ele3) => {
      ele3.traverse(c => {
        c.castShadow = true;
      });
      ele3.scale.multiplyScalar(0.02); 
      lod.addLevel(ele3, 10);
    });

    loaderFbx.load('slon2.fbx', (ele2) => {
      ele2.traverse(c => {
        c.castShadow = true;
      });
      ele2.scale.multiplyScalar(0.02); 
      lod.addLevel(ele2, 20);
    });

    loaderFbx.load('slon1.fbx', (ele1) => {
      ele1.traverse(c => {
        c.castShadow = true;
      });
      ele1.scale.multiplyScalar(0.02); 
      lod.addLevel(ele1, 30);
    });

    lod.position.set(0,0,0)

    this._scene.add(lod);
    this._RAF(); 
  }

  _RAF() {
    requestAnimationFrame((t) => {
       if (this._previousRAF === null) {
         this._previousRAF = t;
       }

      this._RAF();
      this._threejs.render(this._scene, this._camera);
      this._Step(t - this._previousRAF);
      this._previousRAF = t;
    });
  }

  _Step(timeElapsed) {
    const timeElapsedS = timeElapsed * 0.001;
    if (this._mixers) {
      this._mixers.map(m => m.update(timeElapsedS));
    }
  }

  _OnWindowResize() {
    this._camera.aspect = window.innerWidth / window.innerHeight;
    this._camera.updateProjectionMatrix();
    this._threejs.setSize(window.innerWidth, window.innerHeight);
  }
} 

let _APP = null;
window.addEventListener('DOMContentLoaded', () => {
  _APP = new LODDemo();
});
