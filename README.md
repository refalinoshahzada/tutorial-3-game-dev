# Controls
- Move Left (Left Arrow)
- Move Right (Right Arrow)
- Jump (Up Arrow)
- Crouch (Down Arrow)
- Dash (C)
- Interact (Z when near NPC)

# Tutorial 3

## Latihan Mandiri

## Fitur yang dikerjakan
- Double Jump

Saya implementasikan double jump dengan pertama membuat variabel `max_jumps` dan `jump_count` pada script. `max_jumps` menentukan jumlah maksimum lompatan yang bisa dilakukan di udara dan `jump_count` digunakan untuk menghitung berapa kali pemain sudah lakukan aksi jump. Setiap kali tombol lompat ditekan, sistem akan mengecek apakah `jump_count` masih lebih kecil dari `max_jumps`. Jika masih memenuhi syarat nilai `velocity.y` akan diubah sesuai `jump_speed`, dan `jump_count` akan ditambah satu. Ketika karakter menyentuh lantai (`is_on_floor()`), nilai jump_count akan direset ke 0 sehingga pemain dapat kembali melakukan dua kali lompatan. Ini untuk memastikan agar player tidak melakukan aksi jump trus secara infinite.

- Dash

Saya pertama menambahkan variabel `dash_speed`, `dash_duration`, `dash_cooldown`, `is_dashing`, dan `can_dash`. Ketika pemain menekan tombol dash dan kondisi `can_dash` == true, fungsi `start_dash()` akan dipanggil. Pada fungsi tersebut, status `is_dashing` diaktifkan dan karakater melakukan sebuah *dash*. Selama dash berlangsung, pergerakan normal dan gravitasi dihentikan dengan kondisi `if is_dashing` di awal function utama. Durasi dash dihitung menggunakan variabel `dash_time_left` yang dikurangi setiap frame berdasarkan delta. Setelah dash selesai, karakter kembali ke pergerakan normal, dan sistem cooldown dijalankan menggunakan `create_timer()` sebelum `can_dash` diaktifkan kembali. Saya melakukan ini agar karakter dapat melakukan aksi dash, tetapi dengan tidak berlebihan. Also untuk tombol mapping agar ke C saya modify langsung ke project settings godot engine. 

- Crouch

Saya pertama tambahkan variabel `is_crouching` yang akan bernilai true ketika pemain menahan arrow down dan karakter sedang berada di lantai. Saya menggunakan `Input.is_action_pressed()` agar crouch tetap aktif selama tombol ditekan (hold), bukan `is_action_just_pressed()`. Saat crouch aktif, nilai `velocity.x` diatur menjadi nol sehingga karakter tidak dapat bergerak secara horizontal. Selain itu, sistem animasi akan mengganti tampilan karakter menjadi animasi crouch. Saya juga tidak mengganti collision dari character walaupun player melakukan crouch.

- Implementasi Animation and Polishing

Terakhir, saya menambahkan polishing yaitu mengganti Sprite2D menjadi AnimatedSprite2D agar karakter memiliki animasi idle, run, jump, dash, dan crouch. Saya membuat fungsi `update_animation()` untuk menentukan sprite saat melakukan suatu aksi. Selain itu, saya menambahkan `anim.flip_h` agar sprite otomatis menghadap ke arah gerakan karakter.

Reference:
- Movement and Mapping buttons (https://www.youtube.com/watch?v=RDT5hfYWCrQ) 
- AnimatedSprite2D Tutorial (https://www.youtube.com/watch?v=tfdXgiMwUBw&pp=ygUSYW5pbWF0ZWQgc3ByaXRlIDJk) 
- Tutorial GameDev 3 (https://csui-game-development.github.io/tutorials/tutorial-3/)
- GDScript Reference (https://docs.godotengine.org/en/4.3/tutorials/scripting/gdscript/gdscript_basics.html)

# Tutorial 5
Pada Tutorial 5 ini, saya melanjutkan pengembangan game platformer yang telah dibuat pada tutorial sebelumnya dengan menambahkan elemen interaksi serta memperkaya tampilan level agar permainan terasa lebih hidup.

## Latihan Mandiri

- [x] Membuat minimal 1 (satu) objek baru di dalam2 permainan yang dilengkapi dengan animasi menggunakan spritesheet selain yang disediakan tutorial. Silakan cari spritesheet animasi di beberapa koleksi aset gratis seperti Kenney
- [x] Membuat minimal 1 (satu) audio untuk efek suara (SFX) dan memasukkannya ke dalam permainan. Kamu dapat membuatnya sendiri atau mencari dari koleksi aset gratis.
- [x] Membuat minimal 1 (satu) musik latar (background music) dan memasukkannya ke dalam permainan. Kamu dapat membuatnya sendiri atau mencari dari koleksi aset gratis.
- [x] Implementasikan interaksi antara objek baru tersebut dengan objek yang dikendalikan pemain. Misalnya, pemain dapat menciptakan atau menghilangkan objek baru tersebut ketika menekan suatu tombol atau tabrakan dengan objek lain di dunia permainan.
- [x] Implementasikan audio feedback dari interaksi antara objek baru dengan objek pemain. Misalnya, muncul efek suara ketika pemain tabrakan dengan objek baru.


### Implementasi Interaksi dengan NPC
Sebagai bagian dari Latihan Mandiri, saya menambahkan sebuah NPC (Non-Playable Character) yang dapat diajak berbicara oleh pemain. NPC ini dibuat menggunakan aset karakter yang sudah tersedia pada tutorial sebelumnya. Untuk memungkinkan interaksi, saya menambahkan sebuah node `Area2D` dengan `CollisionShape2D` pada NPC yang berfungsi sebagai area deteksi ketika pemain berada di dekat NPC.

Ketika pemain memasuki area tersebut, sinyal `body_entered` akan aktif dan menandakan bahwa pemain berada dalam jarak interaksi. Sebaliknya, ketika pemain keluar dari area tersebut, sinyal `body_exited` akan mematikan status interaksi tersebut. Dengan menggunakan mekanisme ini, pemain hanya dapat berbicara dengan NPC jika berada cukup dekat.

Interaksi dilakukan menggunakan tombol **Z** yang dipetakan pada Input Map sebagai aksi talk. Ketika pemain menekan tombol ini di dekat NPC, maka sebuah dialogue box akan muncul di layar yang menampilkan teks percakapan NPC. Jika tombol ditekan kembali, dialogue box akan disembunyikan kembali.

### Implementasi Dialogue UI
Untuk menampilkan percakapan, saya membuat sebuah UI khusus dialog menggunakan node `CanvasLayer`. Node ini memastikan bahwa elemen UI selalu berada di atas elemen permainan lainnya.

`Panel` digunakan sebagai kotak dialog, sedangkan `Label` digunakan untuk menampilkan teks percakapan. `MarginContainer` ditambahkan agar teks memiliki jarak dari tepi kotak dialog sehingga tampilan menjadi lebih rapi dan mudah dibaca.

Dialogue box ini awalnya disembunyikan (visible = false). Ketika pemain berinteraksi dengan NPC, properti visible akan diubah menjadi true sehingga dialog muncul di layar.

### Implementasi SFX dan BGM
Untuk membuat level terasa lebih hidup, saya juga menambahkan efek suara ketika Player berinteraksi dengan NPC menggunakan node `AudioStreamPlayer2D` dan background music pada game. 

### Penambahan Background level
Selain interaksi NPC, saya juga menambahkan background pada level menggunakan node `Sprite2D`. Background ini ditempatkan di belakang elemen permainan dengan mengatur nilai Z Index menjadi lebih rendah sehingga tidak menutupi objek lain seperti pemain atau NPC.

## Referensi
- Nodes and Scenes
https://docs.godotengine.org/en/stable/tutorials/scripting/nodes_and_scene_instances.html 
- UI
https://www.youtube.com/watch?v=5Hog6a0EYa0&pp=ygUPdWkgc3lzdGVtIGdvZG90 
- BGM and SFX
https://www.youtube.com/watch?v=N3p-7iJWRBY&pp=ygURbmdtIGFuZCBzZnggZ29kb3Q%3D 

## Credits

Beberapa aset yang digunakan dalam proyek ini:
- Background Image
  Source: https://stock.adobe.com/id/search?k=2d+game+background  

  Author:  2dvill

- Interact SFX
  Source: https://www.youtube.com/watch?v=TGXTXvEUuPQ&pp=ygUfcm9ibG94IHBpenphIHBsYWNlIHNvdW5kIGVmZmVjdA%3D%3D 

  Author: Dued1

- BGM
  Source: https://www.youtube.com/watch?v=a3mxLL7nX1E&pp=ygUba2V2aW4gbWFjbGVvZCBzbmVha3kgc25pdGNo 
  
  Author: Kevin Macleod