{include file='common/header.tpl'}

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
        </h4>
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

        {if $blocked eq true}
        <h4 class="pull-right">
          BLOCKED
        </h4>

        {elseif $auction.idleiloeiro neq $USERID}
        <form id="bet" class="input-group" action="{$BASE_URL}actions/auctions/newBid.php" method="post">
          <input name="precoActual" type="number" value="{$itemPrice}" hidden>
          <input name="preco" type="number" class="form-control" placeholder="Place bid..." min="{$itemPrice+0.2}" step="0.20">
          <input name="idAuction" type="number" value="{$auction.idleilao}" hidden>
          <span class="input-group-btn">
            <button class="btn btn-default" type="submit">Bid!</button>
          </span>
        </form><!-- /input-group -->
        {/if}

      </div>
      <div class="ratings">
        <h4>{$auction.nomeproprio}'s rating: </h4>
        <a href="#" class="pull-right">Report this auction</a>
        <p>
          {if round($auction.estrelas) gt 0}
          {round($auction.estrelas)}
          <span class="glyphicon glyphicon-star"></span>
          {else}
          No rating
          {/if}
        </p>
      </div>
    </div>

    <div class="well"> <!-- comments -->

      <div class="row">

        <div class="leaveComment">
          <h4>Leave a Comment:</h4>
          <form role="form"  action="{$BASE_URL}actions/auctions/newComment.php" method="post">
            <div class="form-group">
              <input name="idAuction" type="number" value="{$auction.idleilao}" hidden>
              <textarea name="textComment" class="form-control" rows="3"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
          </form>
        </div>
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
