import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../style/app_color.dart';

class InfoAppController extends GetxController {
  String appName;
  String packageName;
  String version;
  String buildNumber;
  var htmlData = """
    <html>
    <body>
     <p>Vindy Bagus Prasetyo membangun aplikasi esensi sebagai aplikasi Gratis. 
      LAYANAN ini disediakan oleh Vindy Bagus Prasetyo 
      tanpa biaya dan dimaksudkan untuk digunakan apa adanya.
      </p> <p>Halaman ini digunakan untuk memberi tahu pengunjung mengenai 
        kebijakan saya dengan pengumpulan, penggunaan, dan 
        pengungkapan Informasi Pribadi jika ada yang memutuskan 
        untuk menggunakan Layanan saya.
      </p> <p>Jika Anda memilih untuk menggunakan Layanan saya, maka Anda 
        menyetujui pengumpulan dan penggunaan informasi sehubungan 
        dengan kebijakan ini. Informasi Pribadi yang saya kumpulkan 
        digunakan untuk menyediakan dan meningkatkan Layanan. Saya 
        tidak akan menggunakan atau membagikan informasi Anda dengan 
        siapa pun kecuali sebagaimana dijelaskan dalam Kebijakan 
        Privasi ini.
      </p> <p>Istilah yang digunakan dalam Kebijakan Privasi ini memiliki 
        arti yang sama seperti dalam Syarat dan Ketentuan kami, yang 
        pada dasarnya dapat diakses kecuali ditentukan lain dalam 
        Kebijakan Privasi ini.
      </p> <p><strong>Pengumpulan dan Penggunaan Informasi</strong></p> <p>
        Untuk pengalaman yang lebih baik, saat menggunakan Layanan kami, saya mungkin meminta Anda untuk memberikan kami informasi pengenal pribadi tertentu, antara lain : 
        <ul><li>Data pribadi seperti nama, wajah, jabatan.</li>
        <li>Akses lokasi untuk untuk kegiatan presensi dengan mencari selisih dengan lokasi kantor.</li>
        <li>Akses kamera yang digunakan untuk kegiatan presensi yang berguna untuk pendeteksi wajah dan pengenalan wajah.</li></ul>
      </p> <!----> <p><strong>Log Data</strong></p> <p>
        Saya ingin memberi tahu Anda bahwa setiap kali Anda 
        menggunakan Layanan saya, jika terjadi kesalahan dalam 
        aplikasi, saya mengumpulkan data dan informasi (melalui 
        produk pihak ketiga) di ponsel Anda yang disebut Data Log. 
        Data Log ini dapat mencakup informasi seperti alamat Protokol 
        Internet (“IP”) perangkat Anda, nama perangkat, versi 
        sistem operasi, konfigurasi aplikasi saat menggunakan Layanan
        saya, waktu dan tanggal penggunaan Layanan oleh Anda, dan 
        statistik lainnya.
      </p> <p><strong>Cookies</strong></p>
      <p>Cookie adalah file dengan sejumlah kecil data yang biasanya 
        digunakan sebagai pengidentifikasi unik anonim. Ini dikirim 
        ke browser Anda dari situs web yang Anda kunjungi dan 
        disimpan di memori internal perangkat Anda.</p>
      <p>Layanan ini tidak menggunakan “cookies” ini secara eksplisit. 
        Namun, aplikasi dapat menggunakan kode dan perpustakaan pihak 
        ketiga yang menggunakan "cookies" untuk mengumpulkan informasi 
        dan meningkatkan layanan mereka. Anda memiliki pilihan untuk 
        menerima atau menolak cookie ini dan mengetahui kapan cookie 
        dikirim ke perangkat Anda. Jika Anda memilih untuk menolak 
        cookie kami, Anda mungkin tidak dapat menggunakan beberapa 
        bagian dari Layanan ini.</p>
      <p><strong>Penyedia jasa</strong></p> <p>
        Saya dapat mempekerjakan perusahaan dan individu pihak 
        ketiga karena alasan berikut:
      </p> 
      <ul><li>Untuk memfasilitasi Layanan kami;</li> 
      <li>Untuk menyediakan Layanan atas nama kami;</li> 
      <li>Untuk melakukan layanan terkait Layanan; atau</li> 
      <li>Untuk membantu kami dalam menganalisis bagaimana Layanan 
      kami digunakan.</li>
      </ul> <p>Saya ingin memberi tahu pengguna Layanan ini bahwa pihak 
        ketiga ini memiliki akses ke Informasi Pribadi mereka. 
        Alasannya adalah untuk melakukan tugas yang diberikan kepada 
        mereka atas nama kita. Namun, mereka berkewajiban untuk tidak 
        mengungkapkan atau menggunakan informasi tersebut untuk 
        tujuan lain.
      </p> <p><strong>Keamanan</strong></p> <p>
        Saya menghargai kepercayaan Anda dalam memberikan Informasi 
        Pribadi Anda kepada kami, oleh karena itu kami berusaha untuk 
        menggunakan cara yang dapat diterima secara komersial untuk 
        melindunginya. Tetapi ingat bahwa tidak ada metode transmisi 
        melalui internet, atau metode penyimpanan elektronik yang 100% 
        aman dan andal, dan saya tidak dapat menjamin keamanan 
        mutlaknya.
      </p> <p><strong>Tautan ke Situs Lain</strong></p> <p>
        Layanan ini mungkin berisi tautan ke situs lain. Jika Anda 
        mengklik tautan pihak ketiga, Anda akan diarahkan ke situs 
        itu. Perhatikan bahwa situs eksternal ini tidak dioperasikan 
        oleh saya. Oleh karena itu, saya sangat menyarankan Anda 
        untuk meninjau Kebijakan Privasi situs web ini. Saya tidak 
        memiliki kendali atas dan tidak bertanggung jawab atas konten, 
        kebijakan privasi, atau praktik dari situs atau layanan pihak 
        ketiga mana pun.
      </p> <p><strong>Privasi Anak-anak</strong></p> <!----> <div><p>
        Saya tidak secara sadar mengumpulkan informasi pengenal 
        pribadi dari anak-anak. Saya mendorong semua anak untuk tidak 
        pernah mengirimkan informasi pengenal pribadi apa pun melalui 
        Aplikasi dan/atau Layanan. Saya mendorong orang tua dan wali 
        hukum untuk memantau penggunaan Internet anak-anak mereka dan 
        membantu menegakkan Kebijakan ini dengan menginstruksikan 
        anak-anak mereka untuk tidak pernah memberikan informasi 
        pengenal pribadi melalui Aplikasi dan/atau Layanan tanpa izin 
        mereka. Jika Anda memiliki alasan untuk meyakini bahwa 
        seorang anak telah memberikan informasi pengenal pribadi 
        kepada kami melalui Aplikasi dan/atau Layanan, silakan 
        hubungi kami. Anda juga harus berusia minimal 16 tahun untuk 
        menyetujui pemrosesan informasi pengenal pribadi Anda di 
        negara Anda (di beberapa negara kami mengizinkan orang tua 
        atau wali Anda melakukannya atas nama Anda).
        </p></div>
      <p><strong>Perubahan pada Kebijakan Privasi Ini</strong></p> 
      <p>Saya dapat memperbarui Kebijakan Privasi kami dari waktu ke 
      waktu. Oleh karena itu, Anda disarankan untuk meninjau halaman 
      ini secara berkala untuk setiap perubahan. Saya akan memberi 
      tahu Anda tentang perubahan apa pun dengan memposting Kebijakan 
      Privasi baru di halaman ini.
      </p> <p>Kebijakan ini berlaku mulai 2022-07-04</p> 
      <p><strong>Hubungi kami</strong></p> <p>
        Jika Anda memiliki pertanyaan atau saran tentang Kebijakan 
        Privasi saya, jangan ragu untuk menghubungi saya di 
        ti.vindyprasetyo@gmail.com.
      </p> <p>Halaman kebijakan privasi ini dibuat di <a href="https://privacypolicytemplate.net" target="_blank" rel="noopener noreferrer">privacypolicytemplate.net </a>and modified/generated by <a href="https://app-privacy-policy-generator.nisrulz.com/" target="_blank" rel="noopener noreferrer">App Privacy Policy Generator</a></p>
    </body>
    </html>
      """;
  @override
  void onInit() async {
    super.onInit();
    getPackageInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void openWA() async {
    var noWA = "+6285737777778";
    var waURL = "whatsapp://send?phone=" + noWA + "&text=Hallo";
    if (await canLaunch(waURL)) {
      await launch(waURL);
    } else {
      Get.snackbar('Error', 'Anda belum menginstall WhatsApp');
    }
  }

  openTerm() {
    Get.defaultDialog(
        cancel: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.backgroundColor),
            child: TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Kembali',
                style: TextStyle(
                    color: AppColor.whiteColor, fontFamily: 'poppins'),
              ),
            )),
        title: 'Kebijakan Privasi',
        titleStyle:
            TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.bold),
        content: Container(
          height: Get.height / 1.5,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Html(
              data: htmlData,
              defaultTextStyle: TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
              ),
            ),
          ),
        ));
  }

  Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    update();
  }
}
