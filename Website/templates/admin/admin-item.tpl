
{include file='common/header.tpl'}
{include file='admin/admin-bar.tpl'}
<div id="wrapper">
  
  <!-- Sidebar -->
  <!-- Sidebar -->
  <div id="sidebar-wrapper">
    <ul id="sidebar_menu" class="sidebar-nav">
     <li class="sidebar-brand"><a id="menu-toggle" href="#">Admin<span id="main_icon" class="glyphicon glyphicon-align-justify"></span></a></li>
   </ul>
   <ul class="sidebar-nav" id="sidebar">   

   {if $blocked eq false}
    <li><a href="{$BASE_URL}actions/admin/bloqueio.php?idAuction={$auction.idleilao}">Block<span class="sub_icon glyphicon glyphicon-lock"></span></a></li>
    {else}
    <li><a href="{$BASE_URL}actions/admin/desbloqueio.php?idAuction={$auction.idleilao}">Unlock<span class="sub_icon glyphicon glyphicon-lock"></span></a></li>
    {/if}
  </ul>
</div>
<script type="text/javascript">
$("#menu-toggle").click(function(e) {
  e.preventDefault();
  $("#wrapper").toggleClass("active");
});
</script>
</div>

<!-- Page Content -->
<div class="container">

  <div class="row">

    <div class="col-md-3">
      <div class="panel-group" id="accordionOne">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="panel-title">
              <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionOne" href="#collapseOne">Categories:</a> <span class="caret"></span>
            </h4>
          </div>
          <div class="panel-collapse collapse in" id="collapseOne">
            <div class="list-group">
             {foreach $categories as $category}
             {if $category.idcategoria == $auction.idcategoria}
             <a href="{$BASE_URL}pages/search.php?category={$category.idcategoria}" class="list-group-item active">{$category.tipo}</a>
             {else}
             <a href="{$BASE_URL}pages/search.php?category={$category.idcategoria}" class="list-group-item">{$category.tipo}</a>
             {/if}
             {/foreach}
           </div>
         </div>
       </div>
     </div>

     <div class="panel-group" id="accordionTwo">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordionTwo" href="#collapseTwo">Bidders</a> <span class="caret"></span>
          </h4>
        </div>
        <div class="panel-collapse collapse in" id="collapseTwo">
          <div class="list-group">
            {if count($bidders) == 0}
            <a href="#" class="list-group-item">No bidders</a>
            {else}
            {foreach $bidders as $bidder}
            <a href="#" class="list-group-item"><span class="badge">{$bidder.preco}€</span> {$bidder.nomeproprio}</a>
            {/foreach}
            {/if}
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-md-9">

    <div class="thumbnailCarousel">
     <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
          {foreach $images as $img}
          <li data-target="#carousel-example-generic" data-slide-to="2"></li>
          {/foreach}
      </ol>
      <div class="carousel-inner">


        <div class="item active">
          <img class="slide-image" src="../{$firstImage.localizacao}" alt="">
        </div>

        {foreach $images as $img}
        <div class="item">
          <img class="slide-image" src="../{$img.localizacao}" alt="">
        </div>
        {/foreach}
      </div>
      <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
      </a>
      <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
      </a>
    </div>
    <div class="caption-full">
      <h4 class="pull-right text-right">
        <small class="pull-right">Buyout: {$auction.precocompraimediata}</small>
        <br>
        <small class="ratings no-padding">{count($bidders)} bids</small>
        <script src="{$BASE_URL}javascript/jquery.js"></script>
        <script src="{$BASE_URL}javascript/timeleft.js"></script>
        <h4><a href="{$BASE_URL}pages/profile.php?id={$auction.idleiloeiro}">{$auction.nomeproprio}</a>'s <a href="">{$auction.nome}</a></h4>
        
        <h4 class="h4time"><span class="glyphicon glyphicon-time" aria-hidden="true"></span> </h4>
        <input id="time" type="number" value="{$timeleft}" hidden>
        <h4 class="pull-right">
          Current Value:
          {$itemPrice} €
        </h4>

        <p>{$auction.descricao}</p>
        <br>

        <div class="ratings">
          <h4>{$auction.nomeproprio}'s rating: </h4>
          <a href="#" class="pull-right">Report this auction</a>
          <p>
            {for $index = 1 to $auction.rating}
            <span class="glyphicon glyphicon-star"></span>
            {/for}
            {for $index = 1 to 5 - $auction.rating}
            <span class="glyphicon glyphicon-star-empty"></span>
            {/for}
            {$auction.rating} stars
          </p>
        </div>
      </div>

      <div class="well"> <!-- comments -->

        <div class="row">

          <h2 class="page-header">
            Comments
          </h2>
          <section class="comment-list">


           <link href="{$BASE_URL}css/comment.css" rel="stylesheet">
           <!--  Comment -->
           {foreach $comments as $com}


           <article class="row">
            <div class="col-md-2 col-sm-2 hidden-xs">
              <div class="thumbnailUsers">
                <img class="img-responsive user-photo" src="{$BASE_URL}{$com.localizacao}">
              </div><!-- /thumbnail -->
            </div><!-- /col-sm-1 -->


            <div class="col-md-10 col-sm-10">
               {if $com.bloqueio eq ''}
                <form action="{$BASE_URL}actions/admin/bloqueio.php" method="GET">
                <input name="idComentario" value="{$com.idcomentario}"type="hidden" class="btn btn-danger" >
                <input type="submit" class="btn btn-danger" value="Block" onclick="">
                </form>
                 {else}
                 <form action="{$BASE_URL}actions/admin/desbloqueio.php" method="GET">
                <input name="idComentario" value="{$com.idcomentario}"type="hidden" class="btn btn-danger" >
                <input type="submit" class="btn btn-danger" value="Unlock" onclick="">
                </form>
                {/if}
              <div class="panel panel-default">
                <div class="panel-heading">
                  <a href="{$BASE_URL}pages/profile.php?id={$com.idutilizador}"><strong>{$com.utilizador}</strong></a>
                  <span class="text-muted">{$com.data}</span>
                </div>
                <div class="panel-body">
                  {$com.texto}
                </div><!-- /panel-body -->
              </div><!-- /panel panel-default -->
            </div><!-- /col-sm-5 -->
          </article>
          <br>
          {/foreach}



        </section>
      </div>
    </div>
  </div>


</div>
<!-- /.well -->

</div>

</div>

</div>
<!-- /.container -->

{include file='common/footer.tpl'}
