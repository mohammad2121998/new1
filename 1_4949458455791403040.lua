<?php

ob_start();
define('API_KEY','');
echo "https://api.telegram.org/bot".API_KEY."/setwebhook?url=".$_SERVER['SERVER_NAME']."".$_SERVER['SCRIPT_NAME'];
function bot($method,$datas=[]){
    $url = "https://api.telegram.org/bot".API_KEY."/".$method;
$ch = curl_init();
    curl_setopt($ch,CURLOPT_URL,$url);
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
    curl_setopt($ch,CURLOPT_POSTFIELDS,$datas);
    $res = curl_exec($ch);
    if(curl_error($ch)){
        var_dump(curl_error($ch));
    }else{
        return json_decode($res);
    }
}



$update = json_decode(file_get_contents('php://input'));
$message = $update->message;
$chat_id = $message->chat->id;
$text = $message->text;
$chat_id2 = $update->callback_query->message->chat->id;
$message_id = $update->callback_query->message->message_id;
$data = $update->callback_query->data;
$from_id = $message->from->id;
$sudo = 442888702; // ايديك
$m = file_get_contents("$chat_id.txt");
if (!is_dir('co')) {
	mkdir('co');
}
if ($text == '/start' or $text == '🏛┇الصفحه الرئيسية') {
	unlink($chat_id.'.txt');
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'👋🏻┇اهلا بك ؛ '.$message->from->first_name.'
🔽┇يمكنك اختيار احدى اقسام التحويل',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎶┇قسم الصوت'],['text'=>'🎥┇قسم الفديو']],
				[['text'=>'🎆┇قسم الصور']]
			]
		]),'resize_keyboard'=>true
	]);
}
if ($text == '🎆┇قسم الصور') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'☑️┇تم اختبار قسم ؛ 🎆┇قسم الصور
🔽┇يمكنك اختيار نوع التحويل',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'ملصق ~⪼ صوره'],['text'=>'صوره ~⪼ ملصق']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
}
if ($text == 'صوره ~⪼ ملصق') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎆┇الان ارسل الصوره لتحويلها الى ملصق',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎆┇قسم الصور']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "pho->sti");
}
if ($message->photo and $m == 'pho->sti') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->photo[1]->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.png",file_get_contents($file));
	    bot('sendsticker',[
	    	'chat_id'=>$chat_id,
	    	'sticker'=>new CURLFile("co/$chat_id.png")
	    ]);
	    unlink("co/$chat_id.png");
}
if ($text == 'ملصق ~⪼ صوره') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎆┇الان ارسل الملصق لتحويله الى صوره',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎆┇قسم الصور']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "sti->pho");
}
if ($message->sticker and $m == 'sti->pho') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->sticker->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.jpg",file_get_contents($file));
	    bot('sendphoto',[
	    	'chat_id'=>$chat_id,
	    	'photo'=>new CURLFile("co/$chat_id.jpg")
	    ]);
	    unlink("co/$chat_id.jpg");
}
if ($text == '🎥┇قسم الفديو') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'☑️┇تم اختبار قسم ؛ 🎥┇قسم الفديو
🔽┇يمكنك اختيار نوع التحويل',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'فديو ~⪼ mp3'],['text'=>'فديو ~⪼ بصمه']],
				[['text'=>'متحركه ~⪼ فديو'],['text'=>'فديو ~⪼ متحركه']],
				[['text'=>'متحركه ~⪼ فديو نوت'],['text'=>'فديو ~⪼ فديو نوت']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
}
if ($text == 'فديو ~⪼ فديو نوت') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎥┇الان ارسل الفديو لتحويله الى فديو نوت
❗️┇يجب ان يكون الفديو مربع',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎥┇قسم الفديو']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "mp4->not");
}
if ($message->video and $m == 'mp4->not') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->video->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.mp4",file_get_contents($file));
	    bot('sendVideoNote',[
	    	'chat_id'=>$chat_id,
	    	'video_note'=>new CURLFile("co/$chat_id.mp4")
	    ]);
	    unlink("co/$chat_id.mp4");
}
if ($text == 'فديو ~⪼ متحركه') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎥┇الان ارسل الفديو لتحويله الى متحركه',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎥┇قسم الفديو']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "mp4->doc");
}
if ($message->video and $m == 'mp4->doc') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->video->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.mp4",file_get_contents($file));
	    bot('senddocument',[
	    	'chat_id'=>$chat_id,
	    	'document'=>new CURLFile("co/$chat_id.mp4")
	    ]);
	    unlink("co/$chat_id.mp4");
}
if ($text == 'فديو ~⪼ بصمه') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎥┇الان ارسل الفديو لتحويله الى بصمه',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎥┇قسم الفديو']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "mp4->ogg");
}
if ($message->video and $m == 'mp4->ogg') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->video->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.ogg",file_get_contents($file));
	    bot('sendvoice',[
	    	'chat_id'=>$chat_id,
	    	'voice'=>new CURLFile("co/$chat_id.ogg")
	    ]);
	    unlink("co/$chat_id.ogg");
}
if ($text == 'فديو ~⪼ mp3') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎥┇الان ارسل الفديو لتحويله الى mp3',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎥┇قسم الفديو']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "mp4->mp3");
}
if ($message->video and $m == 'mp4->mp3') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->video->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.mp3",file_get_contents($file));
	    bot('sendaudio',[
	    	'chat_id'=>$chat_id,
	    	'audio'=>new CURLFile("co/$chat_id.mp3")
	    ]);
	    unlink("co/$chat_id.mp3");
}
if ($text == '🎶┇قسم الصوت') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'☑️┇تم اختبار قسم ؛ 🎶┇قسم الصوت
🔽┇يمكنك اختيار نوع التحويل',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'mp3 ~⪼ صوت'],['text'=>'🎶┇قسم الصوت']],
				[['text'=>'صوت ~⪼ فديو نوت'],['text'=>'mp3 ~⪼ فديو نوت']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
}
if ($text == 'mp3 ~⪼ فديو نوت') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎶┇الان ارسل mp3 لتحويلها الى فديو نوت',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎶┇قسم الصوت']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "mp3->not");
}
if ($message->audio and $m == 'mp3->not') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->audio->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.mp4",file_get_contents($file));
	    bot('sendVideoNote',[
	    	'chat_id'=>$chat_id,
	    	'video_note'=>new CURLFile("co/$chat_id.mp4")
	    ]);
	    unlink("co/$chat_id.mp4");
}
if ($text == 'صوت ~⪼ فديو نوت') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎶┇الان ارسل الصوت لتحويله الى فديو نوت',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎶┇قسم الصوت']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "ogg->not");
}
if ($message->voice and $m == 'ogg->not') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->voice->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.mp4",file_get_contents($file));
	    bot('sendVideoNote',[
	    	'chat_id'=>$chat_id,
	    	'video_note'=>new CURLFile("co/$chat_id.mp4")
	    ]);
	    unlink("co/$chat_id.mp4");
}
if ($text == 'صوت ~⪼ mp3') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎶┇الان ارسل الصوت لتحويله الى mp3',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎶┇قسم الصوت']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "ogg->mp3");
}
if ($message->voice and $m == 'ogg->mp3') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->voice->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.mp3",file_get_contents($file));
	    bot('sendaudio',[
	    	'chat_id'=>$chat_id,
	    	'audio'=>new CURLFile("co/$chat_id.mp3")
	    ]);
	    unlink("co/$chat_id.mp3");
}
if ($text == 'mp3 ~⪼ صوت') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🎶┇الان ارسل mp3 لتحويلها الى صوت',
		'reply_markup'=>json_encode([
			'keyboard'=>[
				[['text'=>'🎶┇قسم الصوت']],
				[['text'=>'🏛┇الصفحه الرئيسية']]
			]
		]),'resize_keyboard'=>true
	]);
	file_put_contents("$chat_id.txt", "mp3->ogg");
}
if ($message->audio and $m == 'mp3->ogg') {
	bot('sendMessage',[
		'chat_id'=>$chat_id,
		'text'=>'🕧┇جاري التحويل انتظر قليلا'
	]);
	$file = "https://api.telegram.org/file/bot".API_KEY."/".bot('getfile',['file_id'=>$message->audio->file_id])->result->file_path;
	    file_put_contents("co/$chat_id.ogg",file_get_contents($file));
	    bot('sendvoice',[
	    	'chat_id'=>$chat_id,
	    	'voice'=>new CURLFile("co/$chat_id.ogg")
	    ]);
	    unlink("co/$chat_id.ogg");
}