<?php
include_once ('../config/init.php');
include_once ($BASE_DIR . 'database/categories.php');
include_once ($BASE_DIR . 'database/auctions.php');
include_once ($BASE_DIR . 'database/bids.php');
include_once ($BASE_DIR . 'database/admin.php');

if($_SESSION['usertype'] != 'admin')
  {
    header ('Location: ' . $BASE_URL . 'pages/404.php');
  }

if (isset( $_GET['id']))
{
$auctionid = $_GET['id'];
  $auction = getAuctionById ($auctionid);
$auction = getAuctionById ($auctionid);

$blocked = false;

if(checkBlockUser($auction['idleiloeiro']) || checkBlockAuction($auction['idleilao']))
  $blocked = true;

$smarty->assign ('blocked', $blocked);


//Our dates
$date1 = date('m/d/Y h:i:s a', time());
$date2 = $auction['datalimite'];
//Convert them to timestamps.
$date1Timestamp = strtotime($date1);
$date2Timestamp = strtotime($date2);
 
//Calculate the difference.
$timeleft = $date2Timestamp - $date1Timestamp;
 
$smarty->assign ('timeleft', $timeleft);

  
  $categories = getAllCategories ();
  $smarty->assign ('categories', $categories);

  $smarty->assign ('auction', $auction);
  $bidders = getBiddersByAuctionId ($auctionid);

  $itemPrice = $auction['precoinicial'];
  foreach ($bidders as $bidd) {
    if($bidd['preco'] > $itemPrice)
      $itemPrice = $bidd['preco'];
  }

    $comments = getCommentsAuction($auctionid);

  $smarty->assign ('comments', $comments);

  $images = getImages($auctionid);

  $firstImage = $images[0];
  unset($images[0]);
  $smarty->assign ('images', $images);
  $smarty->assign ('firstImage', $firstImage);

  $smarty->assign ('itemPrice', $itemPrice);

  $smarty->assign ('bidders', $bidders);
  $smarty->assign('TITLE', 'Auction: ' . $auction['nome']);
  $smarty->display ('admin/admin-item.tpl');
}
else
{
  header ('Location: ' . $BASE_URL . 'pages/404.php');
}
?>
