import * as THREE from 'three'

const scene = new THREE.Scene()
scene.fog = new THREE.Fog(0x0f0f12, 10, 200)

const camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 300)
camera.position.set(0, 2, 0)

const renderer = new THREE.WebGLRenderer({ antialias: true })
renderer.setSize(window.innerWidth, window.innerHeight)
renderer.setPixelRatio(window.devicePixelRatio)
renderer.setClearColor(0x0f0f12)
document.body.appendChild(renderer.domElement)

const light = new THREE.DirectionalLight(0xffffff, 0.8)
light.position.set(5, 10, 5)
scene.add(light)
scene.add(new THREE.AmbientLight(0xffffff, 0.3))

const groundGeometry = new THREE.PlaneGeometry(50, 500)
const groundMaterial = new THREE.MeshStandardMaterial({ color: 0x44464f })
const ground = new THREE.Mesh(groundGeometry, groundMaterial)
ground.rotation.x = -Math.PI / 2
ground.position.z = -200
scene.add(ground)

const clock = new THREE.Clock()
const speed = 12
const wrapDistance = 200

function onResize() {
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()
  renderer.setSize(window.innerWidth, window.innerHeight)
}

window.addEventListener('resize', onResize)

function animate() {
  const delta = clock.getDelta()
  camera.position.z -= speed * delta
  if (camera.position.z < -wrapDistance) {
    camera.position.z = 0
  }
  renderer.render(scene, camera)
  requestAnimationFrame(animate)
}

animate()
